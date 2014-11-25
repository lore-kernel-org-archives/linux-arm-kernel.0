From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 25 Nov 2014 16:13:04 +0100
Subject: [RFC 0/2] Fix Arndale Octa/Peach Pi boot on Audio subsystem clocks
In-Reply-To: <1416927292.26128.8.camel@AMDC1943>
References: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
 <54736AD0.4070909@collabora.co.uk> <1416907375.5023.54.camel@AMDC1943>
 <547485F5.50600@collabora.co.uk> <1416925325.26128.6.camel@AMDC1943>
 <547497B2.3010907@collabora.co.uk> <1416927292.26128.8.camel@AMDC1943>
Message-ID: <54749C80.3050702@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 11/25/2014 03:54 PM, Krzysztof Kozlowski wrote:
> 
> My patch only fixed the gate clocks but it didn't touched div and mux.
> I'll prepare a v2 of it (I got some feedback) which I hope will fix both
> cases: i2s and disabling unused clocks.
>

Perfect, I will gladly test on Peach boards once you post it.

Thanks a lot for your help.

Best regards,
Javier
