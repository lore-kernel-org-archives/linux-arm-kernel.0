From: robherring2@gmail.com (Rob Herring)
Date: Thu, 3 Sep 2015 16:55:59 -0500
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <20150903084735.GB3784@ulmo.nvidia.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
 <20150903084735.GB3784@ulmo.nvidia.com>
Message-ID: <CAL_Jsq+F=eE6vU3f-bHrrSCD9GCoh80Nf-5=Qm73QgGDW1Np=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2015 at 3:47 AM, Thierry Reding <treding@nvidia.com> wrote:
> On Wed, Sep 02, 2015 at 03:17:57PM -0500, Rob Herring wrote:
> [...]
>> Are there any eDP panels which don't have EDID and need panel details in DT?
>
> Most panels need information other than EDID. They typically have some
> requirements regarding the power up sequence that aren't to be found
> anywhere in EDID or detectable by some other mechanism. A decision was
> therefore made a long time ago to require panels to be listed in DT with
> a specific compatible string. That way all of these details can be
> stashed away in drivers that know how to deal with these kinds of
> details.

I guess I was being hopeful that eDP was improving that situation.

Rob
