From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Oct 2012 15:07:33 -0600
Subject: [PATCH] ARM: tegra: rename the file of "sleep-tXX" to
 "sleep-tegraXX"
In-Reply-To: <CAOesGMhnYZmEZPdpBDmQ+JYxgZRDXZ97O3Wizy91DwxHZFGWpw@mail.gmail.com>
References: <1349691837-30488-1-git-send-email-josephl@nvidia.com>
 <CAOesGMhnYZmEZPdpBDmQ+JYxgZRDXZ97O3Wizy91DwxHZFGWpw@mail.gmail.com>
Message-ID: <5075E395.4070608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2012 02:54 PM, Olof Johansson wrote:
> On Mon, Oct 8, 2012 at 3:23 AM, Joseph Lo <josephl@nvidia.com> wrote:
>> For the naming consistency under the mach-tegra, we re-name the file of
>> "sleep-tXX" to "sleep-tegraXX" (e.g., sleep-t30 to sleep-tegra30).
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> 
> Why rename? It's just churn.

The CPUs are named TegraNN not TNN, so for consistency the files should
be named that way. This is almost the last instance; everything else got
renamed as a side-effect of adding splitting things up for Tegra30
support. Oh, except tegra2_emc.c which can be renamed whenever it's
moved to an appropriate drivers/ directory.
