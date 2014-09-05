From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 05 Sep 2014 10:20:57 +0300
Subject: [PATCH v4 4/4] pinctrl: qcom: Make the target processor value
 configurable
In-Reply-To: <CACRpkdZQouNk0z1AQHbjULJXdRK07-kZDXLcnx0Xayew0fnocA@mail.gmail.com>
References: <1409761696-15435-1-git-send-email-gdjakov@mm-sol.com>	<1409761696-15435-5-git-send-email-gdjakov@mm-sol.com>
 <CACRpkdZQouNk0z1AQHbjULJXdRK07-kZDXLcnx0Xayew0fnocA@mail.gmail.com>
Message-ID: <54096459.7020201@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2014 07:20 PM, Linus Walleij wrote:
> On Wed, Sep 3, 2014 at 6:28 PM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
> 
>> Currently the value used to specify that interrupts from the gpio should
>> be routed to the application processor is hardcoded for all Qualcomm SoCs.
>> But the new APQ8084 SoC uses a different value. To resolve this, we make
>> this value configurable for each SoC. For all existing SoCs we continue
>> to use the current value, and only for APQ8084 we use the new value.
>>
>> Suggested-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> 
> Patch applied.
> 
> Yours,
> Linus Walleij
> 

Thank you, Bjorn and Linus!
