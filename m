From: eric.long@linaro.org (Eric Long)
Date: Fri, 22 Jan 2016 17:15:04 +0800
Subject: [RESEND PATCH 0/2] Remove the mistakes detected by the check
 tools.
In-Reply-To: <CANLsYkzqFaPs2XbF0kC_jbG1=Jry2+bZMHMq-m9gUxMkoLAhnA@mail.gmail.com>
References: <cover.1453271738.git.eric.long@linaro.org>
 <CANLsYkzqFaPs2XbF0kC_jbG1=Jry2+bZMHMq-m9gUxMkoLAhnA@mail.gmail.com>
Message-ID: <CAL=D6xaMAG04tnx_WCbTkcGpyAVBVnz3au1ahDFB72k4DpbKsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2016 at 00:56, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> Please run checkpath.pl on your patches.  Also if the changes are of a
> different nature, ex. indentation problem and wrong argument to a
> function, please provide two separate patches.
>

Hi Mathieu,

I had already ran checkpath.pl, and there was no error and warning.
All the changes are either indentation problems or wrong argument,
except one static defined problem. So I think there is no need to
separate the patch.
By the way, the patches I had send were created base on the check
tools, one for smatch and another for sparse. In case I need to separate
the patches, do I need to follow the this principle. Thanks.

Best Regards.
Eric
