From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 03 Jan 2012 15:21:35 -0800
Subject: [PATCH] Input: tegra-kbc - add device tree support
In-Reply-To: <CAOesGMhYscMgsNbZ+W0vdcRFmMiV3yQYLRxgGLfMVHKuhEAe-w@mail.gmail.com>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F1203@HQMAIL01.nvidia.com>
 <CAOesGMhYscMgsNbZ+W0vdcRFmMiV3yQYLRxgGLfMVHKuhEAe-w@mail.gmail.com>
Message-ID: <2662846.nxkJH3EzFi@dtor-d630.eng.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 03, 2012 02:58:57 PM Olof Johansson wrote:
> On Tue, Jan 3, 2012 at 2:42 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Olof Johansson wrote at Tuesday, January 03, 2012 3:28 PM:
> >> This includes an optional "linux,fn-keymap" binding that is not yet
> >> implemented, that will be used to specify the Fn-key modifier layout
> >> if needed.
> >> 
> >> diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt
> > 
> > ...
> > 
> >> +Required properties:
> >> +- compatible: "nvidia,tegra20-kbc", "matrix-keyboard-controller"
> > 
> > I think "matrix-keyboard-controller" should be dropped now?
> 
> Crap, yeah, I had dropped it but forgot to commit before I did send-email.
> 
> Dmitry, if this is the only comment, do you want me to resend or are
> you OK with editing yourself before applying?

Olof,

Any chance I could get a patch against my 'next' branch? I already applied
patch that did DT bindings without keymap support.

Thanks.

-- 
Dmitry
