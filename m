From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 09:12:56 +0900
Subject: [PATCH 1/3] ARM: dts: exynos5422-odroidxu3: use cd-gpio method to
 detect sd-card
In-Reply-To: <1111856990.2419183.1444661252893.JavaMail.yahoo@mail.yahoo.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <561B3739.4040701@samsung.com> <561B3A83.6090607@samsung.com>
 <1111856990.2419183.1444661252893.JavaMail.yahoo@mail.yahoo.com>
Message-ID: <561C4C88.2040004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.10.2015 23:47, Anand Moon wrote:
>>
>> Anand,
>>
>> You essentially reverted here af6ad88acbd6 ("ARM: dts: Mux XMMCnDATA[0]
>> pad correctly for Exynos5420 boards"). Why? There is no explanation in
>> the commit message about this.
> 
> I don't remember to send the patch relevant to this. Hmm...
> Well, Is this patch really signed-off by me?
> 
> Best Regards,
> 
> Jaehoon Chung
>>
>> Best regards,
>> Krzysztof
>>
> 
>>
> 
> 
> Some how I don't receive these mail on my email id.
> 
> I have picked up these changes from tizen repository for OdroidXU3.
> I have tested with this changes to detect UHS-I micro cd cards.
> That's the reason for this email. 

... and you applied it blindly without looking at actual existing
contents and at previous commits.

That is not how patches from different repositories should be cherry picked.

Best regards,
Krzysztof
