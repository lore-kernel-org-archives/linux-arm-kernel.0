From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Apr 2015 10:53:46 +0100
Subject: Building DTS, problem with includes
In-Reply-To: <2A6B56A6-CEF1-4616-B651-D0A00FC330E5@sigpipe.me>
References: <2A6B56A6-CEF1-4616-B651-D0A00FC330E5@sigpipe.me>
Message-ID: <20150409095346.GW12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 11:34:19AM +0200, Dashie wrote:
> Hi,
> 
> I?ve re-started playing with my kirkwood board and still need to get a properly working DTB.
> 
> I?ve tried repos from :
>   - arm-soc (for-next branch)
>   - linus one from kernel.org git
> 
> With the two i got the error :
> ./dtc -I dts -O dtb ../kirkwood-verbatim-powerbay.dts
> Error: ../kirkwood-verbatim-powerbay.dts:3.1-9 syntax error
> FATAL ERROR: Unable to parse input tree

Use the kernel build system to build the dts from the kernel.  Don't
try and bypass the build system.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
