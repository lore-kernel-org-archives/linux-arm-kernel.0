From: dianders@chromium.org (Doug Anderson)
Date: Mon, 16 Jun 2014 11:30:23 -0700
Subject: [PATCH 1/3] ARM: dts: Create a cros-ec-keyboard fragment
In-Reply-To: <539F33FE.8040501@wwwdotorg.org>
References: <1401920421-25729-1-git-send-email-dianders@chromium.org>
 <539F33FE.8040501@wwwdotorg.org>
Message-ID: <CAD=FV=W=qvzM6i3GhOsHO_2tPEZOVjq+TEKUrfdCVk_4eRo-Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Mon, Jun 16, 2014 at 11:14 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/04/2014 04:20 PM, Doug Anderson wrote:
>> All ChromeOS ARM devices that have the standard "CrOS EC" have the
>> same keyboard mapping.  It's silly to include this same definition
>> everywhere.  Let's create a "dtsi" fragment that we can include from
>> many different boards.
>>
>> This fragment is based on what's currently in tegra124-venice2.dts
>
> I've applied this series to Tegra's for-3.17/dt-cros-ec-kbd branch. I'll
> send a pull request to arm-soc shortly.

It seems like you might want to merge from Stephen's branch
<https://git.kernel.org/cgit/linux/kernel/git/tegra/linux.git/log/?h=for-3.17/dt-cros-ec-kbd>
into your tree to avoid any future conflicts to exynos5250-snow (and
also to allow you to apply
https://patchwork.kernel.org/patch/4351321/).

-Doug
