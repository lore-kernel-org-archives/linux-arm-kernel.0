From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Apr 2016 16:58:28 +0530
Subject: [PATCH v3 00/16] da8xx USB clocks
In-Reply-To: <57068AF1.8050909@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <57068AF1.8050909@lechnology.com>
Message-ID: <570B8A5C.1050907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thursday 07 April 2016 09:59 PM, David Lechner wrote:
> Any further comments before I submit a v4 patchset? Particularly on
> patches 3 and 4 which are new in this v3 submission and have not been
> commented on yet.

I applied some patches which could be applied independently without
driver dependency. I have pushed those to my for-testing[1] branch where
they will get tested a little more before I send my pull request to ARM-SoC.

For your future submissions, you can drop the patches already applied to
the branch above.

Also, I think it will help if you divide the series into driver and
platform changes. You should keep all maintainers copied in both places.
But dividing the series this way should help concentrate review. This is
a complex series with multiple maintainers involved so it will take some
co-ordination. Hopefully it can still all go into the upcoming merge window.

Regards,
Sekhar

[1]
http://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=for-testing
