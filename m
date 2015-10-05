From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 5 Oct 2015 23:43:48 +0800
Subject: [PATCH v5 2/5] soc: sunxi: Add driver for Allwinner Reduced
 Serial Bus
In-Reply-To: <20151004141639.GD2696@lukather>
References: <1443700673-24312-1-git-send-email-wens@csie.org>
 <1443700673-24312-3-git-send-email-wens@csie.org>
 <20151004141639.GD2696@lukather>
Message-ID: <CAGb2v6693tYRFukPw-XaYVxsh9q8QHG9Z=KNs4xgeX+3UkgHWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 4, 2015 at 10:16 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Oct 01, 2015 at 07:57:48PM +0800, Chen-Yu Tsai wrote:
>> Reduced Serial Bus (RSB) is an Allwinner proprietery interface
>> used to communicate with PMICs and other peripheral ICs.
>>
>> RSB is a two-wire push-pull serial bus that supports 1 master
>> device and up to 15 active slave devices.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Slightly confused. Are we merging this through your tree or directly
through arm-soc?

Thanks!
ChenYu
