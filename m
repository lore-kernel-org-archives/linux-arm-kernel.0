From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 17 Feb 2013 00:53:39 +0530
Subject: [RFC PATCH 06/18] davinci: replace V4L2_OUT_CAP_CUSTOM_TIMINGS
 by V4L2_OUT_CAP_DV_TIMINGS
In-Reply-To: <CA+V-a8tH8GLKz50i216S4TFkNjPpn1D1tNaRkuLfvDE_JO9N5g@mail.gmail.com>
References: <a9599acc7829c431d88b547de87c500968ccb86a.1361006882.git.hans.verkuil@cisco.com>
 <1361006901-16103-1-git-send-email-hverkuil@xs4all.nl>
 <697f2939eac3755e4b5d74433d160d44672ab7ca.1361006882.git.hans.verkuil@cisco.com>
 <CA+V-a8tH8GLKz50i216S4TFkNjPpn1D1tNaRkuLfvDE_JO9N5g@mail.gmail.com>
Message-ID: <511FDCBB.5010507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/16/2013 6:28 PM, Prabhakar Lad wrote:
> Cc'ed Sekhar, DLOS, LAK.
> 
> Sekhar Can you Ack this patch ? Or maybe you can take this patch through
> your tree ?

I can take the patch, but I can only send for v3.10 since for v3.9 ARM
tree is only accepting bug fixes for already accepted code. If you wish
to take this through media tree for v3.9, feel free to add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Since this appears to be an ARM-only patch, its better to add an 'ARM:'
prefix to the subject line as is the norm with all other ARM patches.

Thanks,
Sekhar
