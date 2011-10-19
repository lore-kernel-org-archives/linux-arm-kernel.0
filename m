From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Oct 2011 12:45:50 +0200
Subject: [PATCH 2/3] ARM: Add static kernel function stack size analyzer,
	for ARM
In-Reply-To: <4E9E0C66.3020405@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com> <4E9E0C66.3020405@am.sony.com>
Message-ID: <1861853.vLiqXrnQg4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 October 2011 16:31:50 Tim Bird wrote:
> 
> This tool can be used to analyze the function stack size for ARM kernels,
> statically, based on a disassembly of vmlinux (or an individual .o file
> 
> Signed-off-by: Tim Bird <tim.bird@am.sony.com>

Hi Tim,

I thought we now had a gcc option for this. gcc documentation points to -Wstack-usage=XXX.
This was first introduced on s390 in architecture specific gcc code, but should now work
everywhere.

	Arnd
