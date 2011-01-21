From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 10:38:50 +0000
Subject: [PATCH] ARM: mm: Regarding section when dealing with meminfo
In-Reply-To: <AANLkTimsL8YfSdXCBpN2cNVpj8HeJF0f-A7MJQoie+Zm@mail.gmail.com>
References: <1295516739-9839-1-git-send-email-pullip.cho@samsung.com>
	<1295544047.9039.609.camel@nimitz>
	<20110120180146.GH6335@n2100.arm.linux.org.uk>
	<AANLkTimsL8YfSdXCBpN2cNVpj8HeJF0f-A7MJQoie+Zm@mail.gmail.com>
Message-ID: <20110121103850.GI13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:12:27AM +0900, KyongHo Cho wrote:
> Since the size of section is 256 mib and NR_BANKS is defined as 8,
> no ARM system can have more RAM than 2GiB in the current implementation.
> If you want banks in meminfo not to cross sparsemem boundaries,
> we need to find another way of physical memory specification in the kernel.

There is no problem with increasing NR_BANKS.
