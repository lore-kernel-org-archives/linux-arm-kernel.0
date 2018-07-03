From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 17:07:45 -0600
Subject: [RFC PATCH 5/5] arm: dts: zynq: remove "zynq" prefix from
 compatible property
In-Reply-To: <CAHbBuxpuAC0PDfFBQ+D_zJu-AmWFNhEWCojr8LAWfO-ootLqEg@mail.gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-6-luaraneda@gmail.com>
 <042f6632-f4f6-d278-9859-b8998468c3bf@xilinx.com>
 <CAHbBuxpuAC0PDfFBQ+D_zJu-AmWFNhEWCojr8LAWfO-ootLqEg@mail.gmail.com>
Message-ID: <20180703230745.GA2129@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 03:18:49AM -0400, Luis Araneda wrote:
> Hi Michal,
> 
> On Thu, Jun 28, 2018 at 2:42 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > zynq name here is correct which is saying that hardblock is going to be
> > described. Without it it is suggesting that hardblock is not used and it
> > is for example on zybo with microblaze.
> 
> In my opinion, the zynq name is just adding redundant information to
> the "xlnx,zynq-7000" value.

Maybe so, but you can't just go around changing compatible strings. Once 
set, it's an ABI.

Rob
