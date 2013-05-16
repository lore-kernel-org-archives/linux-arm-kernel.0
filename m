From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 May 2013 19:21:22 +0100
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <51945F27.7010003@codeaurora.org>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <518D320C.4010707@elopez.com.ar>
 <fe9e603e-a432-4a29-a195-fd393b875a7e@TX2EHSMHS006.ehs.local>
 <518D411D.9070209@elopez.com.ar>
 <CAPtuhTgsP4gvMAFoQb3icXAZw3ucSg4dfrAdJMho-VxNmNTvwg@mail.gmail.com>
 <518D7C45.2090602@codeaurora.org>
 <20130511142132.GA3200@sirena.org.uk>
 <51945F27.7010003@codeaurora.org>
Message-ID: <20130516182122.GG1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 09:23:03PM -0700, Saravana Kannan wrote:
> On 05/11/2013 07:21 AM, Mark Brown wrote:

> >It's much harder when it's in the standard kernel and there's no contact
> >with some of the users.  I've pushed back pretty strongly on some of
> >your equivalent stuff for regulators for this reason.

> Agreed. I don't really keep up with what's going on with the MSM regulators.

> But at some point, I'll start requesting for this for debugfs. It's
> terribly handy to debug power issues, run unit tests and for debug
> sessions (debugfs. So, clearly!).

Sure, it's handy for debugging - but it's also far too handy for writing
silly things in userspace which isn't something we want to encourage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130516/efb1430b/attachment.sig>
