From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 6 Jun 2017 17:19:16 -0700
Subject: [PATCH 0/4] [media] davinci: vpif_capture: raw camera support
In-Reply-To: <519d0131-b9a7-4afa-78d4-8bb6dccec1ad@xs4all.nl>
References: <20170602213431.10777-1-khilman@baylibre.com>
 <519d0131-b9a7-4afa-78d4-8bb6dccec1ad@xs4all.nl>
Message-ID: <CAOi56cX2wUvMOoCAGnay0b6weTSuS1+xeO2V7pryfe+aM3Jq8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 1:34 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> Hi Kevin,
>
> On 02/06/17 23:34, Kevin Hilman wrote:
>> This series fixes/updates the support for raw camera input to the VPIF.
>>
>> Tested on da850-evm boards using the add-on UI board.  Tested with
>> both composite video input (on-board tvp514x) and raw camera input
>> using the camera board from On-Semi based on the aptina,mt9v032
>> sensor[1], as this was the only camera board with the right connector
>> for the da850-evm UI board.
>>
>> Verified that composite video capture is still working well after these
>> updates.
>
> Can you rebase this patch series against the latest media master branch?
>
> Mauro merged a lot of patches, in particular the one switching v4l2_of_ to
> v4l2_fwnode_. And that conflicts with patches 2 and 4.

Rebased and resent as v2.

Kevin
