From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 23:18:16 +0900
Subject: [PATCH 2/7] clk: samsung: Add clock driver for S3C64xx SoCs
In-Reply-To: <6817507.KeKqs2jZHz@flatron>
References: <1370476651-6743-1-git-send-email-tomasz.figa@gmail.com>
 <2388977.5Y1ahHeZcl@flatron> <20130612165108.26381.54381@quantum>
 <6817507.KeKqs2jZHz@flatron>
Message-ID: <51C1BDA8.60906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/13 06:38, Tomasz Figa wrote:

[...]

>>> Another thing is that it's unlikely for any new SoC from S3C64xx
>>> series to show up, so basically the clock list is fixed.
>>
>> Sure.  I can take this into clk-next along with patch #1, or if you
>> prefer:
>>
>> Acked-by: Mike Turquette<mturquette@linaro.org>
>
> Thanks.
>
> IMHO with all the remaining platform patches in this series, it should go
> through Samsung tree.
>

Mike, thanks for your ack. Let me take this whole series into samsung 
tree when ready for other dependencies like PWM...

- Kukjin
