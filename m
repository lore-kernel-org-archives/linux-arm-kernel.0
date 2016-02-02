From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 2 Feb 2016 11:50:03 +0100
Subject: [PATCH 1/2] Document: i2c: Add a dt binding for mediatek MT2701
 soc
In-Reply-To: <20160108074523.GA1523@katana>
References: <1451888138-11471-1-git-send-email-liguo.zhang@mediatek.com>
 <20160104095511.GB1524@katana> <1452215573.2088.1.camel@mhfsdcap03>
 <20160108074523.GA1523@katana>
Message-ID: <56B089DB.5060806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/16 08:45, Wolfram Sang wrote:
> On Fri, Jan 08, 2016 at 09:12:53AM +0800, liguo zhang wrote:
>> On Mon, 2016-01-04 at 10:55 +0100, Wolfram Sang wrote:
>>> On Mon, Jan 04, 2016 at 02:15:37PM +0800, Liguo Zhang wrote:
>>>> Add a dt binding for the MT2701 soc.
>>>>
>>>> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
>>>
>>> This should probably go with the other patch via arm-soc, or?
>>
>> The patch about i2c dts info for MT2701 depends on the MT2701 clock
>> patch. After the MT2701 clock patch is accepted, the i2c patch for
>> MT2701 may be accepted.
>
> OK. Still, dts changes go via arm-soc 99% of the cases if there is no
> specific need to go via i2c.
>

No specific need here. I will take it through my branch as soon as the 
clock driver is accepted.

Liguo, please poke me on this, when this has happened and you have the 
feeling, I forgot about.
