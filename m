From: davem@davemloft.net (David Miller)
Date: Thu, 15 Mar 2018 11:15:04 -0400 (EDT)
Subject: [PATCH 0/5] DPAA Ethernet fixes
In-Reply-To: <AM5PR04MB3267BC402A80D9E772BC8903ECD00@AM5PR04MB3267.eurprd04.prod.outlook.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
 <1521052994.4790.148.camel@infinera.com>
 <AM5PR04MB3267BC402A80D9E772BC8903ECD00@AM5PR04MB3267.eurprd04.prod.outlook.com>
Message-ID: <20180315.111504.399791580409893462.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
Date: Thu, 15 Mar 2018 09:32:35 +0000

>> -----Original Message-----
>> From: Joakim Tjernlund [mailto:Joakim.Tjernlund at infinera.com]
>> Sent: Wednesday, March 14, 2018 8:43 PM
>> To: davem at davemloft.net; Madalin-cristian Bucur
>> <madalin.bucur@nxp.com>
>> 
>> On Wed, 2018-03-14 at 08:37 -0500, Madalin Bucur wrote:
>> > Hi,
>> >
>> > This patch set is addressing several issues in the DPAA Ethernet
>> > driver suite:
>> >
>> >  - module unload crash caused by wrong reference to device being left
>> >    in the cleanup code after the DSA related changes
>> >  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
>> >    module unload
>> >  - a couple of error counter fixes, a duplicated init in dpaa_eth.
>> 
>> hmm, some of these(all?) bugs are in stable too, CC: stable perhaps?
> 
> Hi Jocke,
> 
> I did not check that, they should be added.

Networking patches are not queued to stable by CC:'ing stable.

Instead you just simply need to ask me explicitly for -stable submission
which I will do at the appropriate time after the fixes have been able
to cook in Linus's tree for a little while.

I've queued this series up for that purpose, thanks.
