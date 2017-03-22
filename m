From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 23 Mar 2017 00:19:02 +0530
Subject: [PATCH v7 1/3] Input: max11801_ts: Add missing of_match_table
In-Reply-To: <20170322184421.GB2899@dtor-ws>
References: <1490180808-2856-1-git-send-email-jagan@openedev.com>
 <20170322183039.GA2899@dtor-ws>
 <CAMty3ZApz+GVkeoT4-75tiJcn6-CxkzdOrMcH7hjK1k2Ht=ZUQ@mail.gmail.com>
 <20170322184421.GB2899@dtor-ws>
Message-ID: <CAMty3ZCtv1a=YNcZ+WXP=-P1DN5NQe975G4DbR-82Pi_O1asCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 12:14 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Mar 23, 2017 at 12:05:17AM +0530, Jagan Teki wrote:
>> On Thu, Mar 23, 2017 at 12:00 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Wed, Mar 22, 2017 at 04:36:46PM +0530, Jagan Teki wrote:
>> >> From: Jagan Teki <jagan@amarulasolutions.com>
>> >>
>> >> Added missing of_match_table for max11801_ts driver with
>> >> compatible as "maxim,max11801_ts"
>> >>
>> >
>> > Why not "maxim,max11801"? Also, I think we'd need a binding document.
>>
>> Compatibility purpose to make this is for touchscreen and few of other
>
> Compatibility with what? The i2c id is "max11801" (without the "-ts").

Do we need to sync with i2c id as well? egalax_ts.c follow "_ts"
of-course the i2c there as follow the same.

>
>> *_ts.c files follow the same, and added binding documentation in 2/3
>> patch.
>
> Sorry, it seems I am only copied on 1/3 patch.

Sorry, will add in next version patches.

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
