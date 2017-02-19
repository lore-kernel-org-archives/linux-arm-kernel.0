From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Feb 2017 22:44:09 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170219214409.GC32327@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-02-15 18:19:16, Steve Longerbeam wrote:
> v4l2_pipeline_inherit_controls() will add the v4l2 controls from
> all subdev entities in a pipeline to a given video device.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170219/db57b10d/attachment.sig>
