From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 3 May 2016 09:59:34 -0300
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: Add audio support
In-Reply-To: <20160503125222.GK5874@tiger>
References: <1462233386-23185-1-git-send-email-festevam@gmail.com>
 <20160503125222.GK5874@tiger>
Message-ID: <CAOMZO5Dkci6EmHkg4WSHHaESGW0z0YbNVMoEO5Tcc2N1mY16Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 9:52 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, May 02, 2016 at 08:56:26PM -0300, Fabio Estevam wrote:
>> @@ -86,6 +139,17 @@
>>       };
>>  };
>>
>> +&sai2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_sai2>;
>> +
>
> Forgot to mention that I dropped this newline when applying.

Thanks, Shawn!
