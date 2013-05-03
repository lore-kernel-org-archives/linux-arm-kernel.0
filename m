From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 03 May 2013 12:02:02 +0200
Subject: [PATCH v2] clk: si5351: Allow user to define disabled state for
 every clock output
In-Reply-To: <1367559207-20086-1-git-send-email-marek.belisko@streamunlimited.com>
References: <1367559207-20086-1-git-send-email-marek.belisko@streamunlimited.com>
Message-ID: <51838B1A.4010803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2013 07:33 AM, Marek Belisko wrote:
> From: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>
> This patch adds platform data and DT bindings to allow to overwrite
> the stored disabled state for each clock output.
>
> Signed-off-by: Marek Belisko<marek.belisko@streamunlimited.com>
> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
> ---
> Changes from v1->v2:
> Sebastian Hesselbarth send me updated version of patch which was based
> on v1. Resending with updates.

Marek,

it is ok to be a little bit more noisy about changes. But as I took
your v1 and did it, here is the Changelog:

- add helper to set disabled state for clkout
- make disabled-state property behave like other properties, i.e.
   only overwrite disabled state when set through platform_data or DT

Sebastian
