From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 9 May 2017 10:55:04 +0800
Subject: [PATCH v8 2/7] doc: Add documentation for Coresight CPU debug
In-Reply-To: <20170503222937.GC7860@linaro.org>
References: <1493719717-27698-1-git-send-email-leo.yan@linaro.org>
 <1493719717-27698-3-git-send-email-leo.yan@linaro.org>
 <20170503222937.GC7860@linaro.org>
Message-ID: <20170509025504.GD10347@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Wed, May 03, 2017 at 04:29:37PM -0600, Mathieu Poirier wrote:
> On Tue, May 02, 2017 at 06:08:32PM +0800, Leo Yan wrote:
> > Update kernel-parameters.txt to add new parameter:
> > coresight_cpu_debug.enable is a knob to enable debugging at boot time.
> > 
> > Add detailed documentation, which contains the implementation, Mike
> > Leach excellent summary for "clock and power domain". At the end some
> > examples on how to enable the debugging functionality are provided.
> > 
> > Suggested-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |   7 +
> >  Documentation/trace/coresight-cpu-debug.txt     | 174 ++++++++++++++++++++++++
> 
> Please add coresight-cpu-debug.txt to the list of maintained files in
> MAINTAINERS.  Moreover I'm pretty sure John will want you to split this patch in
> two, i.e one patch for kernel-parameters.txt and another for
> coresight-cpu-debug.txt

Thanks for the suggestion. Have splited doc related patches and
refined debug module related code as you suggested in another
email and sent out v9 patch set for reviewing.

[...]

Thanks,
Leo Yan
