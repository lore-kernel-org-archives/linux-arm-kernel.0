From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Wed, 19 Sep 2012 06:43:54 -0700
Subject: [PATCH 5/6] staging: drm/imx: Add devicetree binding documentation
In-Reply-To: <20120919065240.GU6180@pengutronix.de>
References: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
 <1347445874-10779-6-git-send-email-s.hauer@pengutronix.de>
 <5058F06C.1020409@boundarydevices.com> <20120919065240.GU6180@pengutronix.de>
Message-ID: <5059CC1A.8000808@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2012 11:52 PM, Sascha Hauer wrote:
> On Tue, Sep 18, 2012 at 03:06:36PM -0700, Eric Nelson wrote:
>> Hi Sascha,
>>
>> On 09/12/2012 03:31 AM, Sascha Hauer wrote:
>>> From: Philipp Zabel<p.zabel@pengutronix.de>
>>>
>>> Signed-off-by: Philipp Zabel<p.zabel@pengutronix.de>
>>> Signed-off-by: Sascha Hauer<s.hauer@pengutronix.de>
>>> ---
>>>   .../bindings/staging/imx-drm/fsl-imx-drm.txt       |   41 ++++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
>>>
>>> +
>>> +example:
>>> +
>>> +display at di0 {
>>> +	compatible = "fsl,imx-parallel-display";
>>> +	edid = [edid-data];
>>> +	crtc =<&ipu 0>;
>>> +	interface-pix-fmt = "rgb24";
>>> +};
>>
>> Do you have a working sample of [edid-data] for a parallel/LVDS/HDMI
>> display or know a good way to produce one?
>
> No, we are using the of videomode helper, see
>
> http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg18618.html
>
> It is not included here to not add a dependency on it. We are trying to
> mainline this separately.
>
> Sascha
>

Thanks Sascha.
