From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 19 Feb 2014 14:12:34 -0800
Subject: [PATCH v2] ARM: dts: remove bcm11351-brt.dts
In-Reply-To: <CAEPRUYr8_qpL65Q0jCnLXHsZpb27DxuiF6JsZb6eRb4JOX2evg@mail.gmail.com>
References: <1392845512-31333-1-git-send-email-mporter@linaro.org>
 <CAEPRUYr8_qpL65Q0jCnLXHsZpb27DxuiF6JsZb6eRb4JOX2evg@mail.gmail.com>
Message-ID: <CAPdLdqkLV+NODgGS5NxvHaD1P_zpoeEhTnZunEGsR9OZXhWFSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2014 13:37, Christian Daudt <bcm@fixthebug.org> wrote:
> On Wed, Feb 19, 2014 at 1:31 PM, Matt Porter <mporter@linaro.org> wrote:
>> The BCM11351 BRT board will never see the light of day. Remove the BRT
>> dts since it is not maintainable.
>>
>> Reviewed-by: Alex Elder <elder@linaro.org>
>> Signed-off-by: Matt Porter <mporter@linaro.org>
>> ---
>> Changes since v1:
>>         - remove bcm11351-brt from Makefile
>>
>>  arch/arm/boot/dts/Makefile         |  3 +--
>>  arch/arm/boot/dts/bcm11351-brt.dts | 54 --------------------------------------
>>  2 files changed, 1 insertion(+), 56 deletions(-)
>>  delete mode 100644 arch/arm/boot/dts/bcm11351-brt.dts
>>
>
> R.I.P bcm11351...
>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>

There goes our original guinea pig.

Reviewed-by: Markus Mayer <markus.mayer@linaro.org>

-- 
Markus Mayer
Broadcom Landing Team
