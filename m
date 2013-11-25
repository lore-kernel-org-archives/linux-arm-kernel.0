From: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 25 Nov 2013 15:16:54 -0800
Subject: [PATCH] use -fstack-protector-strong
In-Reply-To: <20131125221400.GA11041@www.outflux.net>
References: <20131125221400.GA11041@www.outflux.net>
Message-ID: <5293DA66.6050902@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 02:14 PM, Kees Cook wrote:
> Build the kernel with -fstack-protector-strong when it is available
> (gcc 4.9 and later). This increases the coverage of the stack protector
> without the heavy performance hit of -fstack-protector-all.

What is the difference between the various options?

	-hpa
