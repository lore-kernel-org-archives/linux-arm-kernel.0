From: steve_longerbeam@mentor.com (Steve Longerbeam)
Date: Tue, 3 Jan 2017 12:50:35 -0800
Subject: [PATCH 00/20] i.MX Media Driver
In-Reply-To: <CAOMZO5DM4aRwzCWkRoZLmbCxn155YL+CUR_gJyDh+FjzSKD3PQ@mail.gmail.com>
References: <1483050455-10683-1-git-send-email-steve_longerbeam@mentor.com>
 <CAOMZO5DM4aRwzCWkRoZLmbCxn155YL+CUR_gJyDh+FjzSKD3PQ@mail.gmail.com>
Message-ID: <183d9b6e-c195-128b-e74b-9103a3402dab@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,


On 01/02/2017 01:09 PM, Fabio Estevam wrote:
> Hi Steve,
>
> On Thu, Dec 29, 2016 at 8:27 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
>> This is a media driver for video capture on i.MX.
>>
>> Refer to Documentation/media/v4l-drivers/imx.rst for example capture
>> pipelines on SabreSD, SabreAuto, and SabreLite reference platforms.
>>
>> This patchset includes the OF graph layout as proposed by Philipp Zabel,
>> with only minor changes which are enumerated in the patch header.
> Patches 13, 14 and 19 miss your Signed-off-by tag.

thanks for catching. I've added them to version 2.

Steve

>
> Tested the whole series on a mx6qsabresd:
>
> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
