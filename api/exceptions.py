class RdwvError(Exception):
    """Generic error class for all errors raised"""


class TemplateDoesNotExistError(RdwvError):
    """Template does not exist and has no default"""


class TemplateLoadError(RdwvError):
    """Failed to load template file from disk"""
