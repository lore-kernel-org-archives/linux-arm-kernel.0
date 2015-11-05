From: ssimran@broadcom.com (Simran Rai)
Date: Thu, 5 Nov 2015 12:01:52 -0800
Subject: [PATCH v2 1/2] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
In-Reply-To: <20151104140746.GE1717@sirena.org.uk>
References: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
 <20151104140746.GE1717@sirena.org.uk>
Message-ID: <563BB5B0.5040501@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/4/2015 6:07 AM, Mark Brown wrote:
> On Mon, Nov 02, 2015 at 02:11:23PM -0800, Simran Rai wrote:
>
>> +- channel-group: Surround sound grouping that controls which channel
>> +  outputs belong to a group, specifically useful in Multi-channel
>> +  Interfaces grouping of serial port. In multi-channel stereo, use
>> +  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
>> +  multi-channel grouping, use "5_1".
> I don't really understand what this means or why this is not runtime
> configured.
By runtime configured, do you mean passing the channel grouping through 
machine file? Is there any specific callback that I can use?

I will implement your suggestions from other patches too and send out 
next revision by early next week.

Thanks,
Simran
