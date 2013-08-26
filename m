From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Mon, 26 Aug 2013 20:37:36 +0200
Subject: [PATCH RFC 3/5] ARM: samsung: add clock setup for FIMC and FIMD
In-Reply-To: <1445676.NMCyFEC5q4@amdc1032>
References: <1377517114-20222-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1377517114-20222-4-git-send-email-m.krawczuk@partner.samsung.com>
 <1445676.NMCyFEC5q4@amdc1032>
Message-ID: <521BA070.2000800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(dropping linux-doc mailing list from Cc)

On 08/26/2013 06:19 PM, Bartlomiej Zolnierkiewicz wrote:
> On Monday, August 26, 2013 01:38:32 PM Mateusz Krawczuk wrote:
>> This patch adds code that sets correct parents and rates for clocks
>> used by FIMC and FIMD on Goni board.

This patch is supposed to be a workaround to make the display and camera
subsystem working even without properly configured parent clocks in the
boot-loader, right ? And as such it doesn't really belong to this series
and has been written primarily for the clocks testing purposes ?
I think it can be dropped in the next iteration of this series.

--
Thanks,
Sylwester
