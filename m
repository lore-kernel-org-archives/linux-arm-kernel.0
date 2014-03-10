From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 10 Mar 2014 08:58:24 -0700
Subject: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
In-Reply-To: <20140310153815.GE13661@lee--X1>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
 <20140310114819.GO14976@lee--X1>
 <20140310152859.GA29054@core.coreip.homeip.net>
 <20140310153815.GE13661@lee--X1>
Message-ID: <20140310155824.GB29054@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 03:38:15PM +0000, Lee Jones wrote:
> > > > This patch adds ST Keyscan driver to use the keypad hw a subset
> > > > of ST boards provide. Specific board setup will be put in the
> > > > given dt.
> > > > 
> > > > Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> > > > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> > > 
> > > Are you sure these are in the correct order?
> > > 
> > > What is the history of this commit?
> > > 
> > > > ---
> > > >  .../devicetree/bindings/input/st-keypad.txt        |  50 ++++
> > > 
> > > This should be submitted as a seperate patch.
> > 
> > Why do we have such requirement? To me it would make more sense to add
> > binding documentation in the same commit as the code that uses these
> > bindings.
> 
> I'm inclined to agree with you and that's actually how we used to do
> it, but a decision was made by the DT guys at one of the Kernel
> Summits to submit Documentation as a separate patch.

Do you have background for this decision? To me it is akin splitting
header file into a separate patch.

-- 
Dmitry
