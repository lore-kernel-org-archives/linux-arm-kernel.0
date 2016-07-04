From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jul 2016 10:19:38 +0100
Subject: [PATCH 4/7] bus: arm-cci: add missing of_node_put after calling
 of_parse_phandle
In-Reply-To: <HE1PR04MB1450113E1D3A5B0BBF9269C88B380@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-5-git-send-email-peter.chen@nxp.com>
 <57764626.4060800@arm.com> <20160701103346.GF12735@arm.com>
 <HE1PR04MB1450113E1D3A5B0BBF9269C88B380@HE1PR04MB1450.eurprd04.prod.outlook.com>
Message-ID: <20160704091937.GA1639@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 02:48:08AM +0000, Peter Chen wrote:
> >Please route this via arm-soc once you've addressed Suzuki's comment.
> 
> Hi Will, how to route patch via arm-soc?
> 
> Does it mean sending patch by adding arm at kernel.org at To or Cc list?

Yes. I just wanted to make it clear that I don't intend to pick this up
(since I'd just send it to arm-soc anyway!).

Will
