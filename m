From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 20 Apr 2016 13:15:27 +0200
Subject: [PATCH 1/2] Documentation: DT: vdma: Add clock support for vdma
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A578F73@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1461136800-20334-1-git-send-email-appanad@xilinx.com>
 <CAKfKVtEkfnDqU476troXmCw20ATvQvj-JdPX-BCuPDR-9ZxKHQ@mail.gmail.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A578F73@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <571764CF.6070003@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2016 10:39 AM, Appana Durga Kedareswara Rao wrote:
[...]
>> however  we should keep the names same as the TRM.
> 
> Why?? Why can't we use simple convenient names that refers to equivalent clocks of h/w 

Because it is confusing. If you use the same name it's very straight forward
to understand which clock is being referred to. That's not the case if you
come up with random new names.
