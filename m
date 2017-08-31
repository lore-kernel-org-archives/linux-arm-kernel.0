From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 31 Aug 2017 12:01:37 +0530
Subject: [net-next PATCHv6 0/2] net: ethernet: Socionext Netsec
In-Reply-To: <27A7C5A5-AFF4-49F3-B0DF-7F53283EC2A4@gmail.com>
References: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
 <27A7C5A5-AFF4-49F3-B0DF-7F53283EC2A4@gmail.com>
Message-ID: <CABb+yY0r8ZgeYTdmYqTd3RhUnr1ufOaUUe3+81Q2JKm+xY8PRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 9:36 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On August 30, 2017 3:24:17 AM PDT, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>Hello,
>>
>>The OGMA/Netsec controller is used in latest SoC from
>>Socionext/Fujitsu.
>>
>>I am refreshing the patchset by basically using official name of the IP
>>from 'OGMA' to 'Netsec'. And the company is renamed too, from Fujitsu
>>to Socionext to better reflect the reality.
>>
>> I have addressed comments (that could be) on the last revision -->
>>https://patchwork.kernel.org/patch/4540651/
>>
>> Of course, I have scanned changes to the drivers/net/ethernet since
>>last submission and integrated whichever applicable and rebased the
>>driver on top of last rc.
>
> It does not appear to be at first glance, but I will just ask anyways, this is not yet another variant of stmmac glued just a little bit differently into the SoC right?
>
Sorry, no idea. I will be glad if we could reuse existing code.

Thanks.
