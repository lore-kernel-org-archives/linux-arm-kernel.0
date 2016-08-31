From: zhengyu.shen@nxp.com (Zhengyu Shen)
Date: Wed, 31 Aug 2016 13:46:55 +0000
Subject: [PATCH v3] Added perf functionality to mmdc driver
In-Reply-To: <20160831102937.GC4783@leverpostej>
References: <20160817194253.16300-1-zhengyu.shen@nxp.com>
 <CAHrpEqTtCnEU1v1sEuN8yJGPudDRZ5A79=Wn5Bp4SgTxDiNTQQ@mail.gmail.com>
 <20160830114329.GB8366@tiger> <20160830125420.GG1223@leverpostej>
 <DB5PR04MB1430D8A0284123B5C475800E9FE00@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <20160831102937.GC4783@leverpostej>
Message-ID: <AM3PR04MB1426758359C2B769A28C3B849FE30@AM3PR04MB1426.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Mmdc was only responsible for one crash which I fixed (had to remove
> > the event from the pmu properly).
> 
> Ok. I take it that there will be a v4 appearing shortly with that fix?

Hopefully I'll get that out by the end of today. 
 
> Crashes are very bad. Do you have any logs from those crashes in other
> drivers that you can share?

It seems my kernel source was out of date, updating it seems to have fixed 
The issue.
