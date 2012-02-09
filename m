From: olof@lixom.net (Olof Johansson)
Date: Wed, 8 Feb 2012 17:17:16 -0800
Subject: [GIT PULL v2] mxs/boards for v3.4
In-Reply-To: <20120204003203.GB28377@S2101-09.ap.freescale.net>
References: <20120131154051.GF26436@S2101-09.ap.freescale.net>
 <20120204003203.GB28377@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMh6nprU6MHq7QGRD2TR6HCU4bAa2EFDHHyHCXfgWg8oYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 3, 2012 at 4:32 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Jan 31, 2012 at 11:40:53PM +0800, Shawn Guo wrote:
>> Hi Arnd, Olof,
>>
>> Please pull the following mxs board changes for v3.4. ?It has no
>> conflict with rmk/for-armsoc branch.
>>
> Since you have not pulled it yet, I'm updating it as v2 with Lauri's
> APX4 patch added. ?Please pull.

Hmm, we're normally not that keen on picking up new board files. Since
MX28 isn't converted over to device tree (yet) though, not much to do
about. I've pulled this branch for 3.4.

If there are more MX2* boards coming in over time, we will want to see
them converted over to at least device-tree board probing (i.e. using
just the basic compatible for board and bootargs/mem from a device
tree instead of the allocated machine type and ATAGs).


-Olof
