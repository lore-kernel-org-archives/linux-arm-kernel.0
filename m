From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 23 Sep 2013 15:58:14 +0530
Subject: [PATCH] DT: if dt is available don't use s3c_arch_init
In-Reply-To: <1379931289-29384-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379931289-29384-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <CAK9yfHyKik0ZLsgikGUdOc7xPwPee=JNLCr5P3ZdKU6DA5j4Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mateusz,

On 23 September 2013 15:44, Mateusz Krawczuk
<m.krawczuk@partner.samsung.com> wrote:
> It prevents from executing platform code, when booting from device tree.
>
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---

nit: Please format the patch title appropriately. In this case, it
should start with
"ARM: SAMSUNG: ..."

-- 
With warm regards,
Sachin
