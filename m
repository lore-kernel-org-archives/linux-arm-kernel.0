From: enrico.weigelt@gr13.net (Enrico Weigelt, metux IT consult)
Date: Thu, 29 Jun 2017 13:05:42 +0000
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170629124908.GV4902@n2100.armlinux.org.uk>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <20170629124908.GV4902@n2100.armlinux.org.uk>
Message-ID: <7ff5fe0b-72fa-7a23-44df-59761cc6dd1c@gr13.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.06.2017 12:49, Russell King - ARM Linux wrote:

> The location of the frame buffer is unknown to the decompressor - and
> as the decompressor self-relocates itself (using purely assembly code),
> it could relocate itself on top of the frame buffer, causing the "nice"
> image to become very colourful.

Could the bootloader pass safe (or blocked) memory regions to the
decompressor ?

--mtx
