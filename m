From: rogershimizu@gmail.com (Roger Shimizu)
Date: Mon, 8 Feb 2016 20:09:14 +0900
Subject: [PATCH 1/3] ARM: dts: orion5x: fix the missing mtd flash on
 linkstation lswtgl
In-Reply-To: <20160205204040.GB8063@lunn.ch>
References: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
 <1454689998-9579-2-git-send-email-rogershimizu@gmail.com>
 <20160205204040.GB8063@lunn.ch>
Message-ID: <CAEQ9gE=gjq5kOapphdyzGySaJQrh_PqT4XBL_H89TLNFhqm+yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

On Sat, Feb 6, 2016 at 5:40 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sat, Feb 06, 2016 at 01:33:16AM +0900, Roger Shimizu wrote:
>> MTD flash stores u-boot and u-boot environment on linkstation lswtgl.
>> The latter one can be easily read/write by u-boot-tools package in Debian.
>>
>> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> Thanks for using the partitions node.

Since you did not comment my patch v2 yet, I'm wondering that
- My patch 1/3 is a fix, which fixes the issue since 4.3, so it will
be firstly applied to 4.5-rc branch as usual, and as I understand the
process then it will be backported to 4.4/4.3 stable branch.
- If it's the case described above, it's better not to use partitions
node, which was introduced since 4.4.
- By any case, my v2 patch 2/3 and 3/3, which uses partitions node, is fine.

If you agree, I can submit a v3 in minutes.
Thank you and looking forward to your feedback!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 17B3ACB1
