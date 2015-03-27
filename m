From: jonas@microbit.se (Jonas Andersson)
Date: Fri, 27 Mar 2015 13:51:46 +0100
Subject: at91 clocks
In-Reply-To: <20150327132543.08ad636c@bbrezillon>
References: <55117568.6090202@microbit.se>	<20150325013201.3f01fc22@bbrezillon>	<55127AA6.5050902@microbit.se>	<20150325173751.0d6479df@bbrezillon>	<5513D701.2080201@microbit.se>	<20150326162827.041c051a@bbrezillon>	<55152F3E.60004@microbit.se>	<20150327132003.6caf3689@bbrezillon>
 <20150327132543.08ad636c@bbrezillon>
Message-ID: <55155262.9030501@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
On 2015-03-27 13:25, Boris Brezillon wrote:
> On Fri, 27 Mar 2015 13:20:03 +0100
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>
>
>>> I tested with IS_ERR, changed this to IS_ERR_OR_NULL, but the pointer is ok.
>> Can you print clk_get_rate(parent_clk) result ?
> Could you also paste me the whole clk_summary content ?
>
>
http://pastie.org/10057268

Best regards
  Jonas
