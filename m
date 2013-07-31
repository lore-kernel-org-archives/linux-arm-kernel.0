From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 31 Jul 2013 12:29:27 +0900
Subject: [PATCH 4/5] mmc: dw_mmc: Indicate that regulators may be absent
In-Reply-To: <003901ce8d29$610ab3f0$23201bd0$%jun@samsung.com>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
 <1375184777-25404-4-git-send-email-broonie@kernel.org>
 <003901ce8d29$610ab3f0$23201bd0$%jun@samsung.com>
Message-ID: <51F88497.5020909@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 07/30/2013 10:33 PM, Seungwon Jeon wrote:
> On Tue, July 30, 2013, Mark Brown wrote:
>> From: Mark Brown <broonie@linaro.org>
>>
>> Use regulator_get_optional() to tell the core that requests for regulators
>> can fail in a real system.
>>
>> Signed-off-by: Mark Brown <broonie@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Thanks,
> Seungwon Jeon
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
