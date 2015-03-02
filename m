From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 Mar 2015 12:28:36 +0100
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
References: <201502271645.58765@pali>
 <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20150302112836.GA27317@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-02-27 16:55:26, Pali Roh?r wrote:
> This patch adds support for DT "/revision" and convert ATAG_REVISION to DT.
> 
> Pali Roh?r (2):
>   arm: devtree: Set system_rev from DT revision
>   arm: boot: convert ATAG_REVISION to DT revision field

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
