From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Mar 2012 12:20:13 -0500 (EST)
Subject: [PATCH v3 02/30] ARM: provide runtime hook for ioremap/iounmap
In-Reply-To: <4F558D89.7030905@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
 <1330658022-14559-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1203051415150.31242@xanadu.home>
 <201203052013.26688.arnd@arndb.de>
 <alpine.LFD.2.02.1203051545200.31242@xanadu.home> <4F558D89.7030905@gmail.com>
Message-ID: <alpine.LFD.2.02.1203061219220.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Mar 2012, Rob Herring wrote:

> There's not much point in converting ixp4xx and ebsa110 to runtime hooks
> as they still have other io.h needs.

I think there is.  Uniformity is highly valuable.


Nicolas
