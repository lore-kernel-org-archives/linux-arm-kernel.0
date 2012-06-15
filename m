From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Fri, 15 Jun 2012 09:12:37 -0300
Subject: [PATCH v2 00/23] ARM: LPC32xx specific updates for next
In-Reply-To: <201206151207.07108.arnd@arndb.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
 <201206151207.07108.arnd@arndb.de>
Message-ID: <CAAAP30HU7k2QC9K15V3grZvXDzy8apzBGSo8it+M4KF5wGWLZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 9:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> It all looks good from my point of view, so I think we can pull it
> for 3.6 if no other comments come.

Arn,

Please exclude "ARM: LPC32xx: Remove duplicate usb host clock init".
It's causing problems in some LPC32XX boards.
