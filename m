From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Tue, 11 Oct 2016 15:34:52 -0300
Subject: The possible regression in kernel 4.8 - clk: imx: correct AV PLL
 rate formula
In-Reply-To: <CAOMZO5CVggufx2U0pZUXd1o=i36Jo-c1B=hgFcSaWeM+=oagaQ@mail.gmail.com>
References: <03B5A3CA1724CE4EAC32B27E39292A677FC5A390AE@AUSMAIL1.AUS.ADVANTECH.CORP>
 <WM!ea1806249edeb2cf70790bb7482fb813b9b7cef636576d9ca4b01897c8831c3650f71356a13ce9ba5e358a69b86f6a82!@dg.advantech.com>
 <CAOMZO5CXTEpNvAhuc2Et60HxfM=nQngMTdMOtDbazi=1EQ95Jw@mail.gmail.com>
 <03B5A3CA1724CE4EAC32B27E39292A677FC5A39613@AUSMAIL1.AUS.ADVANTECH.CORP>
 <WM!8b5ef465717800ac4466674b98bb32450dc231d955cd4979ca96fd54828a7c3af7de5f376015ebf046c75f20677161c6!@dgg.advantech.com>
 <WM!8ae38b052eee9a42a4712d13aee34e2d793055d4125e98cc2c03451811f33168b3556d3bf52ee5ba8dda879cea808cdc!@dg.advantech.com>
 <CAOMZO5CVggufx2U0pZUXd1o=i36Jo-c1B=hgFcSaWeM+=oagaQ@mail.gmail.com>
Message-ID: <CAP9ODKoyhkTA2=MR44LJ24OYTJaWrtg9vT=14vnYNnuuSDRe1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 3:00 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Ken,
>
> On Tue, Oct 11, 2016 at 2:49 PM, Ken.Lin <ken.lin@advantech.com> wrote:
>
>> With the patches applied, the pixel clock (148500000 required for 1920x1080 at 60) is correct as we checked in kernel 4.7 and the actual measurement result looked good as we expected.
>> I think the patches should fix the issue.
>
> That's good news. Thanks for testing.
>
> Emil is working on a v3 version of the patch series.
>
> Emil,
>
> Please add Ken Lin on Cc when you submit v3.

And what will be done regarding 4.8? Is the faulty change to be
reverted or this patches will be backported?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
