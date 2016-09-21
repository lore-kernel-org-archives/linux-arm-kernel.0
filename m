From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 21 Sep 2016 09:45:29 -0400
Subject: ftrace function_graph causes system crash
In-Reply-To: <0e38f79fdc1f4671943da74764c15050@SIWEX5A.sing.micron.com>
References: <7d0e88fff8e64591ac31be3adbbf763c@SIWEX5A.sing.micron.com>
 <20160920100716.131d3647@gandalf.local.home>
 <0e38f79fdc1f4671943da74764c15050@SIWEX5A.sing.micron.com>
Message-ID: <20160921094529.6802e97e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Sep 2016 07:50:58 +0000
"Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
 
> 
> Hi, Steve
> Thanks very much! This is a very useful trace tool, I now know the problem function,
> It is gt_counter_read, if not trace this function, ftrace function_graph work well.
> Do you know now how to deeply debug and trace which line is wrong through Ftrace?

Hmm, maybe I should add this into the scripts directory. Yeah, I should
do that.

-- Steve
