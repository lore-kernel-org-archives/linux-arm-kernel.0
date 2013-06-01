From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 01 Jun 2013 10:41:32 +0200
Subject: [PATCH 3/3] ARM: S5P64X0: Remove duplicate uncompress code
In-Reply-To: <1370000944-19786-4-git-send-email-tushar.behera@linaro.org>
References: <1370000944-19786-1-git-send-email-tushar.behera@linaro.org>
 <1370000944-19786-4-git-send-email-tushar.behera@linaro.org>
Message-ID: <51A9B3BC.9000405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/31/2013 01:49 PM, Tushar Behera wrote:
> The uncompress code in S5P64X0 is almost same as the uncompress code
> defined in plat-samsung. Better to reuse that code.
>
> Signed-off-by: Tushar Behera<tushar.behera@linaro.org>
> ---
>   arch/arm/mach-s5p64x0/include/mach/uncompress.h |  163 ++---------------------
>   1 file changed, 8 insertions(+), 155 deletions(-)

Not sure if you are aware of it, Tomasz has already posted a patch that
removes this duplicated code: https://patchwork.kernel.org/patch/2589331
I think that patch is not yet merged though.

Regards,
Sylwester
