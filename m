From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Mar 2014 11:38:39 +0000
Subject: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <20140328101146.GP6120@lukather>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-9-git-send-email-carlo@caione.org>
 <20140328101146.GP6120@lukather>
Message-ID: <20140328113839.GB30768@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 11:11:46AM +0100, Maxime Ripard wrote:

> Here, you would just include the dtsi at the top of the file, and in
> the DTSI, you would have something like:

> &axp209 {
>    regulators {
>       ...
>    }
> }

Hang on, what is an include file setting up regulators for?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/9c468972/attachment.sig>
