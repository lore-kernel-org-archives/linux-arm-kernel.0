From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 May 2016 18:14:03 +0100
Subject: [PATCH v4 10/18] ASoC: sti: Update DT example to match the
 driver code
In-Reply-To: <1464192412-16386-12-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-12-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160527171403.GN16172@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 05:06:44PM +0100, Peter Griffin wrote:
> uniperiph-id, version and mode are ST specific bindings and
> need the 'st,' prefix. Update the examples, as otherwise copying
> them yields a runtime error parsing the DT node.

You've not copied me on the rest of the series so I've no idea what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160527/17a8742a/attachment.sig>
