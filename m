From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Mar 2014 09:43:28 -0500
Subject: [PATCH] arm: boot: dts: build keystone devicetree blob
In-Reply-To: <532C4F40.5010903@ti.com>
References: <1394639330-1288-1-git-send-email-balbi@ti.com>
 <53208CDD.7030106@ti.com> <532C4F40.5010903@ti.com>
Message-ID: <20140321144328.GC12310@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 10:40:00AM -0400, Santosh Shilimkar wrote:
> On Wednesday 12 March 2014 12:35 PM, Santosh Shilimkar wrote:
> > On Wednesday 12 March 2014 11:48 PM, Felipe Balbi wrote:
> >> Currently, even when building keystone only
> >> kernel builds, DTB won't get build because
> >> we lack a Makefile rule to get it compiled.
> >>
> >> This patch adds that rule so mainline kernel
> >> users have a chance to use up-to-date DTB on
> >> keystone 2 platforms.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> ---
> >>
> > We have been building dtbs with explicit command
> > instead of dtbs since it was just one dtb so far
> > supported. Was planning to add the rule once more
> > boards get added. Now with Lamarr and Edision in
> > for next merge window, will do that post 3.15-rc1.
> > 
> Just to close the loop, I added a patch as part
> of my 3.15 fixes which builds all keystone dt
> blobs.

cool, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/d622f2f6/attachment.sig>
