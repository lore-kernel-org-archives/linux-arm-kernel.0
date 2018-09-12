From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Sep 2018 23:54:03 -0300
Subject: i.MX DT memory nodes
In-Reply-To: <20180912023902.GA28239@dragon>
References: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
 <20180912023902.GA28239@dragon>
Message-ID: <CAOMZO5AgrUEqTUwXEm4vkkaDKZs2Yzi7gVYR4MXAN1KsqTz7OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Sep 11, 2018 at 11:39 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Sep 11, 2018 at 04:54:40PM -0500, Rob Herring wrote:
>> It appears that many i.MX platforms have duplicate, incomplete memory
>> nodes with both "memory" and "memory@<addr>" nodes. Are you all aware
>> of this? Plan to fix it? I guess u-boot fixes things enough to work.
>
> @Fabio, it seems that the most of them are caused by the empty 'memory'
> node in <soc>.dtsi.  Can these be removed now?

Yes, I will follow Rob's suggestion and will try to come with a fix.
