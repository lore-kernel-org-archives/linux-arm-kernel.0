From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 24 May 2017 08:14:51 +0800
Subject: [PATCH v11 7/9] coresight: add support for CPU debug module
In-Reply-To: <CANLsYkzosO8+uaphvNQFe80zOJoqkSWceaiWhKEH-xSuVH0uew@mail.gmail.com>
References: <1495548980-30432-1-git-send-email-leo.yan@linaro.org>
 <1495548980-30432-8-git-send-email-leo.yan@linaro.org>
 <CANLsYkzosO8+uaphvNQFe80zOJoqkSWceaiWhKEH-xSuVH0uew@mail.gmail.com>
Message-ID: <20170524001451.GA20279@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Tue, May 23, 2017 at 11:39:16AM -0600, Mathieu Poirier wrote:

[...]

> > +static bool debug_enable;
> > +module_param_named(enable, debug_enable, bool, 0600);
> > +MODULE_PARM_DESC(enable, "Knob to enable debug functionality "
> > +                "(default is 0, which means is disabled by default)");
> 
> Checkpatch complains about a quoted string split across multiple
> lines.  You can probably removes the second one since information
> about the default value is already detailed in patch 03/09.  In this
> case I suggest modifiying the description to:
> 
> "Control to enable coresight CPU debug functionality"

It's shame for checkpatch.pl warning. Although everytime I used script
before sending out patch set, should think a bit more to handle them
better. Have sent new patch set to dismiss them.

Thanks,
Leo Yan
