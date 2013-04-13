From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 13 Apr 2013 12:29:29 +0200
Subject: [PATCH v3] ARM: pci: create pci_common_init_dev()
In-Reply-To: <1365788748-7908-1-git-send-email-linus.walleij@linaro.org>
References: <1365788748-7908-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130413102929.GB30758@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 07:45:48PM +0200, Linus Walleij wrote:
[...]
> +static inline void pci_common_init(struct hw_pci *hw) {

I think that the CodingStyle rule for putting the opening brace on a
line by itself also applies to inline functions.

Aside from that nit:

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130413/9b8b3779/attachment.sig>
