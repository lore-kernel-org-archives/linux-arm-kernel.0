From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 22:21:08 +0000
Subject: [PATCH v3] regulator_get_optional: don't print an error when no
 regulator is found
In-Reply-To: <1387293897-31786-1-git-send-email-hdegoede@redhat.com>
References: <1387293897-31786-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20131217222108.GJ28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 04:24:57PM +0100, Hans de Goede wrote:
> Only print an error when _regulator_get() is expected to return a valid
> regulator, that is when _regulator_get() is called from regulator_get() and
> we're not using the dummy because we don't have full-constraints, or when
> _regulator_get() is called from regulator_get_exclusive() in which case
> returning a dummy is not allowed.

Applied, thanks.  Please use subject lines that match the pattern for
the subsystem and CC the relevant mailing list (you missed lkml here).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/8c35d1eb/attachment.sig>
