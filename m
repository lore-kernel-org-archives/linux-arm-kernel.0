From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 7 Sep 2012 15:10:37 +0200
Subject: [PATCH v3] pwm i.MX: add devicetree support
In-Reply-To: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
References: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120907131037.GD29340@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 02:48:06PM +0200, Sascha Hauer wrote:
> The following is the third version of the i.MX pwm series. I integrated
> the remaining comments from Shawn and Beno?t and added their tags.
> 
> So Thierry, please pull the attached patches. The pull request only
> contains the pwm framework specific patches, the remaining two I'd
> like to push via the arm-soc tree in case the i.MX5 also gets devicetree
> clock lookups.

Hi Sascha,

Sorry for taking so long to get back to you. Apart from my comments to
patch 1, I really like how this series cleans up the i.MX driver. It's
already a bit late in the 3.6 release cycle for these kinds of changes
and none of them fix any regressions, so I'd like to queue them for
3.7 after my comments have been addressed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120907/38f0010b/attachment.sig>
