From: alan@signal11.us (Alan Ott)
Date: Sun, 04 Mar 2012 14:47:31 -0500
Subject: [PATCH v2 2/6] ARM: tegra: select CPU_FREQ_TABLE
In-Reply-To: <20120304183710.GB31064@quad.lixom.net>
References: <1330721908-8633-1-git-send-email-alan@signal11.us>
 <20120304183710.GB31064@quad.lixom.net>
Message-ID: <4F53C6D3.2060404@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/12 1:37 PM, Olof Johansson wrote:
> On Fri, Mar 02, 2012 at 03:58:28PM -0500, Alan Ott wrote:
>> From: Arnd Bergmann<arnd@arndb.de>
>>
>> The tegra cpufreq implementation relies on the cpu_freq_table
>> code, so make sure that this is always there when needed.
>>
>> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
>> Signed-off-by: Alan Ott<alan@signal11.us>
>
> This didn't apply cleanly to the tegra tree (what was it based on?), but
> I fixed it up manually and applied to for-3.4/cleanups-and-fixes.
>

These were based on mainline.

Alan.
