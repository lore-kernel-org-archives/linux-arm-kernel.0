From: Jan.Glauber@cavium.com (Jan Glauber)
Date: Fri, 12 Oct 2018 11:03:34 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
 <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
Message-ID: <20181012110326.GA6721@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 09:48:01AM +0000, Adam Cottrel wrote:
> Hi Will,
> 
> Thank you for getting back to me.
> 
> > [+Robin and Cavium folks -- it's usually best to cc people as well as  mailing
> > the list]
> I will remember this for future. Thanks for the advice.
> 
> > > I am using the ATH10K on Linux 14.4 with an Arm Cavium processor.
> > > During heavy loading, I am seeing that target initiated DMA requests
> > > are being silently dropped under extreme IO memory pressure and it is
> > > proving very difficult to isolate the root cause.
> >
> > Is this ThunderX 1 or 2 or something else? Can you reproduce the issue with
> > mainline?
> I am using:-
>         model = "Cavium ThunderX CN81XX board";
>         compatible = "cavium,thunder-81xx";
> 

Hi Adam,

what is the exact hardware revision (shown in /proc/cpuinfo) ?

--Jan
