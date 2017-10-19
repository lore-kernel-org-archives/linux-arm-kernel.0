From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 22:40:39 +0200
Subject: [PATCH] arm64: defconfig: Enable QCOM_IOMMU
In-Reply-To: <20171011170006.GQ1165@minitux>
References: <20171011151925.30909-1-nicolas.dechesne@linaro.org>
 <20171011170006.GQ1165@minitux>
Message-ID: <CAK8P3a3LODdQUfdrWEms-SaEE-=N4evbsXK9_djBwmsH0FxkNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 7:00 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 11 Oct 08:19 PDT 2017, Nicolas Dechesne wrote:
>
>> Enable QCOM IOMMU driver for 'B' family devices, such as APQ8016 found on the
>> Dragonboard 410c. With this change, graphics console and GPU are working
>> fine (using mesa/freedreno for GPU driver).
>>
>> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied to next/soc, thanks!

       Arnd
